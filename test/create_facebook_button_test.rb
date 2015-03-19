require "cutest"
require_relative "../lib/shareprogress"

# Monkeypath the communication with ShareProgress
module ShareProgress
  module Button
    def self.request(method, payload)
      return {
        "success"=>true,
        "response"=>[{
          "id"=>12154,
          "page_url"=>"http://sumofus.org/",
          "page_title"=>"My Facebook button name",
          "button_template"=>"sp_fb_large",
          "share_button_html"=>"<div class='sp_12154 sp_fb_large' ></div>",
          "found_snippet"=>false,
          "is_active"=>false,
          "variants"=>{
            "facebook"=>[{
              "id"=>48643,
                "facebook_title"=>"Facebook Title 1",
                "facebook_description"=>"Facebook Description 1",
                "facebook_thumbnail"=>"/path/to/images/facebook_1.jpg"}, {
              "id"=>48644,
                "facebook_title"=>"Facebook Title 2",
                "facebook_description"=>"Facebook Description 2",
                "facebook_thumbnail"=>"/path/to/images/facebook_2.jpg"}, {
              "id"=>48645,
                "facebook_title"=>"Facebook Title 3",
                "facebook_description"=>"Facebook Description 3",
                "facebook_thumbnail"=>"/path/to/images/facebook_3.jpg"}],
            "email"=>[{
              "id"=>48647,
                "email_subject"=>"SumOfUs",
                "email_body"=>"SumOfUs is a global movement of consumers, "\
                  "investors, and workers all around the world, standing "\
                  "together to hold corporations accountable for their "\
                  "actions and forge a new, sustainable and just path for "\
                  "our global economy. It's not going to be fast or easy. "\
                  "But if enough of us come together, we can make a real "\
                  "difference.\n{LINK}"}],
            "twitter"=>[{
              "id"=>48646,
              "twitter_message"=>"SumOfUs {LINK}"}]},
          "advanced_options"=>{
            "automatic_traffic_routing"=>true,
            "buttons_optimize_actions"=>true,
            "customize_params"=>{
              "param"=>"param_to_use",
              "e"=>"email_source",
              "f"=>"facebook_source",
              "t"=>"twitter_source",
              "o"=>"dark_social_source"},
            "id_pass"=>{
              "id"=>"id",
              "passed"=>"referrer_id"}}}],
        "message"=>nil}
    end
  end
end

setup do
  {
    "key" => "123456",
    "page_url" => "http://sumofus.org/",
    "page_title" => "My Facebook button name",
    "auto_fill" => true,
    "button_template" => "sp_fb_large",
    "variants" => {
      "facebook" => [
        {"facebook_title" => "Facebook Title 1",
          "facebook_description" => "Facebook Description 1",
          "facebook_thumbnail" => "/path/to/images/facebook_1.jpg"},
        {"facebook_title" => "Facebook Title 2",
          "facebook_description" => "Facebook Description 2",
          "facebook_thumbnail" => "/path/to/images/facebook_2.jpg"},
        {"facebook_title" => "Facebook Title 3",
          "facebook_description" => "Facebook Description 3",
          "facebook_thumbnail" => "/path/to/images/facebook_3.jpg"}
      ]
    },
    "advanced_options" => {
      "automatic_traffic_routing" => true,
      "buttons_optimize_actions" => true,
      "customize_params" => {
        "param" => "param_to_use",
        "e" => "email_source",
        "f" => "facebook_source",
        "t" => "twitter_source",
        "o" => "dark_social_source"
      },
      "id_pass" => {
        "id" => "id",
        "passed" => "referrer_id"
      }
    }
  }
end

scope do
  # all
  test "create facebook button successfully" do |data|
    result = ShareProgress::Button.create(data)

    expected_result = {
      "id"=>12154,
      "page_url"=>"http://sumofus.org/",
      "page_title"=>"My Facebook button name",
      "button_template"=>"sp_fb_large",
      "share_button_html"=>"<div class='sp_12154 sp_fb_large' ></div>",
      "found_snippet"=>false,
      "is_active"=>false,
      "variants"=>{
        "facebook"=>[{
          "id"=>48643,
            "facebook_title"=>"Facebook Title 1",
            "facebook_description"=>"Facebook Description 1",
            "facebook_thumbnail"=>"/path/to/images/facebook_1.jpg"}, {
          "id"=>48644,
            "facebook_title"=>"Facebook Title 2",
            "facebook_description"=>"Facebook Description 2",
            "facebook_thumbnail"=>"/path/to/images/facebook_2.jpg"}, {
          "id"=>48645,
            "facebook_title"=>"Facebook Title 3",
            "facebook_description"=>"Facebook Description 3",
            "facebook_thumbnail"=>"/path/to/images/facebook_3.jpg"}],
        "email"=>[{
          "id"=>48647,
            "email_subject"=>"SumOfUs",
            "email_body"=>"SumOfUs is a global movement of consumers, "\
              "investors, and workers all around the world, standing "\
              "together to hold corporations accountable for their "\
              "actions and forge a new, sustainable and just path for "\
              "our global economy. It's not going to be fast or easy. "\
              "But if enough of us come together, we can make a real "\
              "difference.\n{LINK}"}],
        "twitter"=>[{
          "id"=>48646,
          "twitter_message"=>"SumOfUs {LINK}"}]},
      "advanced_options"=>{
        "automatic_traffic_routing"=>true,
        "buttons_optimize_actions"=>true,
        "customize_params"=>{
          "param"=>"param_to_use",
          "e"=>"email_source",
          "f"=>"facebook_source",
          "t"=>"twitter_source",
          "o"=>"dark_social_source"},
        "id_pass"=>{
          "id"=>"id",
          "passed"=>"referrer_id"}}
    }

    assert result == expected_result
  end

  test "create facebook button with wrong button_template" do |data|
    data["button_template"] = "sp_em_small"

    result = ShareProgress::Button.create(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  test "create facebook button with nil facebook_title" do |data|
    data["variants"]["facebook"][0]["facebook_title"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_title=>[:nil]}

    assert result == expected_result
  end

  test "create facebook button with empty facebook_title" do |data|
    data["variants"]["facebook"][0]["facebook_title"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_title=>[:empty]}

    assert result == expected_result
  end

  test "create facebook button with nil facebook_description" do |data|
    data["variants"]["facebook"][0]["facebook_description"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_description=>[:nil]}

    assert result == expected_result
  end

  test "create facebook button with empty facebook_description" do |data|
    data["variants"]["facebook"][0]["facebook_description"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_description=>[:empty]}

    assert result == expected_result
  end

  test "create facebook button with nil facebook_thumbnail" do |data|
    data["variants"]["facebook"][0]["facebook_thumbnail"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_thumbnail=>[:nil]}

    assert result == expected_result
  end

  test "create facebook button with empty facebook_thumbnail" do |data|
    data["variants"]["facebook"][0]["facebook_thumbnail"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:facebook_thumbnail=>[:empty]}

    assert result == expected_result
  end
end
