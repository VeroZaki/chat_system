# require "application_system_test_case"

# class ApplicationsTest < ApplicationSystemTestCase
#   setup do
#     @application = applications(:one)
#   end

#   test "visiting the index" do
#     visit applications_url
#     assert_selector "h1", text: "applications"
#   end

#   test "should create application" do
#     visit applications_url
#     click_on "New application"

#     fill_in "Chats count", with: @application.chats_count
#     fill_in "Token", with: @application.token
#     click_on "Create application"

#     assert_text "application was successfully created"
#     click_on "Back"
#   end

#   test "should update application" do
#     visit application_url(@application)
#     click_on "Edit this application", match: :first

#     fill_in "Chats count", with: @application.chats_count
#     fill_in "Token", with: @application.token
#     click_on "Update application"

#     assert_text "application was successfully updated"
#     click_on "Back"
#   end

#   test "should destroy application" do
#     visit application_url(@application)
#     click_on "Destroy this application", match: :first

#     assert_text "application was successfully destroyed"
#   end
# end
