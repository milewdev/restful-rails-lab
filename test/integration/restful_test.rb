require 'test_helper'

class RestfulTest < ActionDispatch::IntegrationTest

  
  test 'RESTful get' do
    # setup
    user = User.create!({first_name: 'First', middle_name: 'Middle', last_name: 'Last'})
    
    # run
    get "/users/#{user.id}.json"
    
    # verify
    user_attributes = JSON.parse(response.body)
    assert_equal 'First', user_attributes['first_name']
    assert_equal 'Middle', user_attributes['middle_name']
    assert_equal 'Last', user_attributes['last_name']
  end

  
  test 'RESTful post' do
    # setup
    new_user_attributes = { first_name: 'First', middle_name: 'Middle', last_name: 'Last' }
    request_headers = { "Accept" => "application/json", "Content-Type" => "application/json" }
    
    # run
    post "/users.json", new_user_attributes.to_json, request_headers
    
    # verify
    new_user_id = JSON.parse(response.body)['id']
    new_user = User.find(new_user_id)
    assert_equal 'First', new_user.first_name
    assert_equal 'Middle', new_user.middle_name
    assert_equal 'Last', new_user.last_name
  end

  
  test 'RESTful put' do
    # setup
    user = User.create!({first_name: 'First', middle_name: 'Middle', last_name: 'Last'})
    changes = { id: user.id, first_name: 'Arthur', middle_name: 'Philip', last_name: 'Dent' }
    request_headers = { "Accept" => "application/json", "Content-Type" => "application/json" }
    
    # run
    put "/users/#{user.id}.json", changes.to_json, request_headers
    
    # verify
    changed_user = User.find(user.id)
    assert_equal 'Arthur', changed_user.first_name
    assert_equal 'Philip', changed_user.middle_name
    assert_equal 'Dent', changed_user.last_name
  end

  
  test 'RESTful partial put' do
    # setup
    user = User.create!({first_name: 'First', middle_name: 'Middle', last_name: 'Last'})
    changes = { id: user.id, first_name: 'Arthur' }
    request_headers = { "Accept" => "application/json", "Content-Type" => "application/json" }
    
    # run
    #
    # NOTE: according to the RESTful spec, this should fail since all of a resource's 
    # attributes are to be supplied when using 'put'
    put "/users/#{user.id}.json", changes.to_json, request_headers
    
    # verify
    changed_user = User.find(user.id)
    assert_equal 'Arthur', changed_user.first_name
    assert_equal 'Middle', changed_user.middle_name
    assert_equal 'Last', changed_user.last_name
  end

  
end
