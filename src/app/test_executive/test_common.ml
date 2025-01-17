(* test_common.ml -- code common to tests *)

open Core_kernel
open Async
open Integration_test_lib

module Make (Inputs : Intf.Test.Inputs_intf) = struct
  open Inputs.Engine

  let send_snapp ?(unlock = true) ~logger node parties =
    [%log info] "Sending snapp"
      ~metadata:[ ("parties", Mina_base.Parties.to_yojson parties) ] ;
    match%bind.Deferred
      Network.Node.send_snapp ~unlock ~logger node ~parties
    with
    | Ok _snapp_id ->
        [%log info] "Snapps transaction sent" ;
        Malleable_error.return ()
    | Error err ->
        let err_str = Error.to_string_mach err in
        [%log error] "Error sending snapp"
          ~metadata:[ ("error", `String err_str) ] ;
        Malleable_error.soft_error_format ~value:() "Error sending snapp: %s"
          err_str

  let send_invalid_snapp ?(unlock = true) ~logger node parties substring =
    [%log info] "Sending snapp, expected to fail" ;
    match%bind.Deferred
      Network.Node.send_snapp ~unlock ~logger node ~parties
    with
    | Ok _snapp_id ->
        [%log error] "Snapps transaction succeeded, expected error \"%s\""
          substring ;
        Malleable_error.soft_error_format ~value:()
          "Snapps transaction succeeded, expected error \"%s\"" substring
    | Error err ->
        let err_str = Error.to_string_mach err in
        if String.is_substring ~substring err_str then (
          [%log info] "Snapps transaction failed as expected"
            ~metadata:[ ("error", `String err_str) ] ;
          Malleable_error.return () )
        else (
          [%log error]
            "Error sending snapp, for a reason other than the expected \"%s\""
            substring
            ~metadata:[ ("error", `String err_str) ] ;
          Malleable_error.soft_error_format ~value:()
            "Snapp failed: %s, but expected \"%s\"" err_str substring )

  let get_account_permissions ~logger node account_id =
    [%log info] "Getting permissions for account"
      ~metadata:[ ("account_id", Mina_base.Account_id.to_yojson account_id) ] ;
    match%bind.Deferred
      Network.Node.get_account_permissions ~logger node ~account_id
    with
    | Ok permissions ->
        [%log info] "Got account permissions" ;
        Malleable_error.return permissions
    | Error err ->
        let err_str = Error.to_string_mach err in
        [%log error] "Error getting account permissions"
          ~metadata:[ ("error", `String err_str) ] ;
        Malleable_error.hard_error (Error.of_string err_str)

  let get_account_update ~logger node account_id =
    [%log info] "Getting update for account"
      ~metadata:[ ("account_id", Mina_base.Account_id.to_yojson account_id) ] ;
    match%bind.Deferred
      Network.Node.get_account_update ~logger node ~account_id
    with
    | Ok update ->
        [%log info] "Got account update" ;
        Malleable_error.return update
    | Error err ->
        let err_str = Error.to_string_mach err in
        [%log error] "Error getting account update"
          ~metadata:[ ("error", `String err_str) ] ;
        Malleable_error.hard_error (Error.of_string err_str)

  let get_account_balance ~logger node account_id =
    [%log info] "Getting balance for account"
      ~metadata:[ ("account_id", Mina_base.Account_id.to_yojson account_id) ] ;
    match%bind.Deferred
      Network.Node.get_balance_total ~logger node ~account_id
    with
    | Ok balance ->
        [%log info] "Got account balance" ;
        Malleable_error.return balance
    | Error err ->
        let err_str = Error.to_string_mach err in
        [%log error] "Error getting account balance"
          ~metadata:[ ("error", `String err_str) ] ;
        Malleable_error.hard_error (Error.of_string err_str)

  let get_account_balance_locked ~logger node account_id =
    [%log info] "Getting locked balance for account"
      ~metadata:[ ("account_id", Mina_base.Account_id.to_yojson account_id) ] ;
    match%bind.Deferred
      Network.Node.get_balance_locked ~logger node ~account_id
    with
    | Ok balance ->
        [%log info] "Got account balance" ;
        Malleable_error.return balance
    | Error err ->
        let err_str = Error.to_string_mach err in
        [%log error] "Error getting account balance"
          ~metadata:[ ("error", `String err_str) ] ;
        Malleable_error.hard_error (Error.of_string err_str)

  let compatible_item req_item ledg_item ~equal =
    match (req_item, ledg_item) with
    | Mina_base.Snapp_basic.Set_or_keep.Keep, _ ->
        true
    | Set v1, Mina_base.Snapp_basic.Set_or_keep.Set v2 ->
        equal v1 v2
    | Set _, Keep ->
        false

  let compatible_updates ~(ledger_update : Mina_base.Party.Update.t)
      ~(requested_update : Mina_base.Party.Update.t) : bool =
    (* the "update" in the ledger is derived from the account

       if the requested update has `Set` for a field, we
       should see `Set` for the same value in the ledger update

       if the requested update has `Keep` for a field, any
       value in the ledger update is acceptable

       for the app state, we apply this principle element-wise
    *)
    let app_states_compat =
      let fs_requested =
        Pickles_types.Vector.Vector_8.to_list requested_update.app_state
      in
      let fs_ledger =
        Pickles_types.Vector.Vector_8.to_list ledger_update.app_state
      in
      List.for_all2_exn fs_requested fs_ledger ~f:(fun req ledg ->
          compatible_item req ledg ~equal:Pickles.Backend.Tick.Field.equal)
    in
    let delegates_compat =
      compatible_item requested_update.delegate ledger_update.delegate
        ~equal:Signature_lib.Public_key.Compressed.equal
    in
    let verification_keys_compat =
      compatible_item requested_update.verification_key
        ledger_update.verification_key
        ~equal:
          [%equal:
            ( Pickles.Side_loaded.Verification_key.t
            , Pickles.Backend.Tick.Field.t )
            With_hash.t]
    in
    let permissions_compat =
      compatible_item requested_update.permissions ledger_update.permissions
        ~equal:Mina_base.Permissions.equal
    in
    let snapp_uris_compat =
      compatible_item requested_update.snapp_uri ledger_update.snapp_uri
        ~equal:String.equal
    in
    let token_symbols_compat =
      compatible_item requested_update.token_symbol ledger_update.token_symbol
        ~equal:String.equal
    in
    let timings_compat =
      compatible_item requested_update.timing ledger_update.timing
        ~equal:Mina_base.Party.Update.Timing_info.equal
    in
    let voting_fors_compat =
      compatible_item requested_update.voting_for ledger_update.voting_for
        ~equal:Mina_base.State_hash.equal
    in
    List.for_all
      [ app_states_compat
      ; delegates_compat
      ; verification_keys_compat
      ; permissions_compat
      ; snapp_uris_compat
      ; token_symbols_compat
      ; timings_compat
      ; voting_fors_compat
      ]
      ~f:Fn.id
end
