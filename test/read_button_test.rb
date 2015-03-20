require "cutest"
require_relative "../lib/shareprogress"

# Monkeypath the communication with ShareProgress
module ShareProgress
  module Button
    def self.request(method, payload)
      return {
        "success"=>true,
        "response"=>[{
          "id"=>12196,
          "page_url"=>"https://www.sumofus.org/petition/my_petition_slug",
          "page_title"=>"my_petition_slug-email_button",
          "button_template"=>"sp_em_small",
          "share_button_html"=>"<div class='sp_12196 sp_em_small' ></div>",
          "found_snippet"=>true,
          "is_active"=>true,
          "variants"=>{
            "facebook"=>[{
              "id"=>48883,
              "facebook_title"=>nil,
              "facebook_description"=>nil,
              "facebook_thumbnail"=>nil}],
            "email"=>[{
              "id"=>48881,
                "email_subject"=>"My Subject 1",
                "email_body"=>"My Body 1{LINK}"}, {
              "id"=>48882,
                "email_subject"=>"My Subject 2",
                "email_body"=>"My Body 2{LINK}"}],
            "twitter"=>[{
              "id"=>48884,
                "twitter_message"=>nil}]},
          "advanced_options"=>{
            "automatic_traffic_routing"=>"true",
            "buttons_optimize_actions"=>nil,
            "customize_params"=>nil,
            "id_pass"=>{
              "id"=>"id",
              "passed"=>"referrer_id"}
          }
        }],
        "message"=>nil}
    end
  end
end

setup do
  {
    "key" => "ZAkVqgDTSq63_FE6FWeU3g",
    "id" => "12196"
  }
end

scope do
  # all
  test "read button successfully" do |data|
    result = ShareProgress::Button.read(data)

    expected_result = {
      "id"=>12196,
      "page_url"=>"https://www.sumofus.org/petition/my_petition_slug",
      "page_title"=>"my_petition_slug-email_button",
      "button_template"=>"sp_em_small",
      "share_button_html"=>"<div class='sp_12196 sp_em_small' ></div>",
      "found_snippet"=>true,
      "is_active"=>true,
      "variants"=>{
        "facebook"=>[{
          "id"=>48883,
          "facebook_title"=>nil,
          "facebook_description"=>nil,
          "facebook_thumbnail"=>nil}],
        "email"=>[{
          "id"=>48881,
            "email_subject"=>"My Subject 1",
            "email_body"=>"My Body 1{LINK}"}, {
          "id"=>48882,
            "email_subject"=>"My Subject 2",
            "email_body"=>"My Body 2{LINK}"}],
        "twitter"=>[{
          "id"=>48884,
          "twitter_message"=>nil}]},
      "advanced_options"=>{
        "automatic_traffic_routing"=>"true",
        "buttons_optimize_actions"=>nil,
        "customize_params"=>nil,
        "id_pass"=>{
          "id"=>"id",
          "passed"=>"referrer_id"}
      }
    }

    assert result == expected_result
  end

  # key
  test "read button with nil key" do |data|
    data["key"] = nil

    result = ShareProgress::Button.read(data)

    expected_result = {:key=>[:not_present]}

    assert result == expected_result
  end

  test "read button with empty key" do |data|
    data["key"] = ""

    result = ShareProgress::Button.read(data)

    expected_result = {:key=>[:not_present]}

    assert result == expected_result
  end

  # id
  test "read button with nil id" do |data|
    data["id"] = nil

    result = ShareProgress::Button.read(data)

    expected_result = {:id=>[:not_present]}

    assert result == expected_result
  end

  test "read button with empty id" do |data|
    data["id"] = ""

    result = ShareProgress::Button.read(data)

    expected_result = {:id=>[:not_present]}

    assert result == expected_result
  end
end
