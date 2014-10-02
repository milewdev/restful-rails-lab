restful-rails-lab
=================

The RESTful/HTTP 'patch' verb should be used when some but not necessarily all of a resource's attributes
need to be updated.  'put' should be used when updating all attributes of a resource.

Rails allows 'put' to behave like 'patch'.

A detailed discussion is [here](https://github.com/rails/rails/pull/505).  A conclusion is [here](http://weblog.rubyonrails.org/2012/2/26/edge-rails-patch-is-the-new-primary-http-method-for-updates/).

This tiny rails project demonstrates how Rails allows 'put' to update only some attributes.  See [this](https://github.com/milewgit/restful-rails-lab/blob/master/test/integration/restful_test.rb) test.
