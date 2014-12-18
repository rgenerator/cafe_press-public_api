# CafePress::PublicAPI

CafePress Public API client for Ruby

**NOTICE** Currently has only two calls:

1. `list_deep_by_store`
1. `find_product`

## TODO

* **Do not** use `ActiveSupport::CoreExt::Hash#from_xml`
* Calls needed to create products (`product.create.cp`, `product.save.cp`)
* Use `snake_case` for `page` and `pageSize` options
