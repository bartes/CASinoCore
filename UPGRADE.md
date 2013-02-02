# Upgrade CASinoCore

Here is a list of backward-incompatible changes that were introduced.

## 1.1.0

API changes:

* `login_credential_acceptor`: The parameters of `#process` changed from `params, cookies, user_agent` to just `params, user_agent`

New callbacks:

* `login_credential_requestor` and `login_credential_acceptor` call `#service_not_allowed` on the listener, when a service is not in the service whitelist.
* `api/service_ticket_provider` calls `#service_not_allowed_via_api` on the listener, when a service is not in the service whitelist.