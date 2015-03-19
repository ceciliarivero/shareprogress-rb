require "cutest"
require_relative "../lib/shareprogress"

# Monkeypath the communication with ShareProgress
module ShareProgress
  module Button
    def self.request(method, payload)
      return {
        "success"=>true,
        "response"=>[{
          "id"=>12152,
          "page_url"=>"http://sumofus.org/",
          "page_title"=>"My Twitter button name",
          "button_template"=>"sp_tw_large",
          "share_button_html"=>"<div class='sp_12152 sp_tw_large' ></div>",
          "found_snippet"=>false,
          "is_active"=>false,
          "variants"=>{
            "facebook"=>[{
              "id"=>48616,
              "facebook_title"=>"SumOfUs",
              "facebook_description"=>"SumOfUs is a global movement of "\
                "consumers, investors, and workers all around the world, "\
                "standing together to hold corporations accountable for "\
                "their actions and forge a new, sustainable and just path "\
                "for our global economy. It's not going to be fast or easy. B",
              "facebook_thumbnail"=>"http://sumofus.org/wp-content/themes/pgm/"\
              "img/default-facebook.jpg"}],
            "email"=>[{
              "id"=>48617,
              "email_subject"=>"SumOfUs",
              "email_body"=>"SumOfUs is a global movement of consumers, "\
                "investors, and workers all around the world, standing together "\
                "to hold corporations accountable for their actions and forge a "\
                "new, sustainable and just path for our global economy. It's "\
                "not going to be fast or easy. But if enough of us come "\
                "together, we can make a real difference.\n{LINK}"}],
            "twitter"=>[{
              "id"=>48613,
                "twitter_message"=>"Twitter message 1 {LINK}"}, {
              "id"=>48614,
                "twitter_message"=>"Twitter message 2 {LINK}"}, {
              "id"=>48615,
                "twitter_message"=>"Twitter message 3 {LINK}"}]},
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
        "message"=>nil
      }
    end
  end
end

setup do
  {
    "key" => "123456",
    "page_url" => "http://sumofus.org/",
    "page_title" => "My Twitter button name",
    "auto_fill" => true,
    "button_template" => "sp_tw_large",
    "variants" => {
      "twitter" => [
        {"twitter_message" => "Twitter message 1 {LINK}"},
        {"twitter_message" => "Twitter message 2 {LINK}"},
        {"twitter_message" => "Twitter message 3 {LINK}"}
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
  test "create twitter button successfully" do |data|
    result = ShareProgress::Button.create(data)

    expected_result = {
      "id"=>12152,
      "page_url"=>"http://sumofus.org/",
      "page_title"=>"My Twitter button name",
      "button_template"=>"sp_tw_large",
      "share_button_html"=>"<div class='sp_12152 sp_tw_large' ></div>",
      "found_snippet"=>false,
      "is_active"=>false,
      "variants"=>{
        "facebook"=>[{
          "id"=>48616,
          "facebook_title"=>"SumOfUs",
          "facebook_description"=>"SumOfUs is a global movement of "\
            "consumers, investors, and workers all around the world, "\
            "standing together to hold corporations accountable for their "\
            "actions and forge a new, sustainable and just path for our "\
            "global economy. It's not going to be fast or easy. B",
          "facebook_thumbnail"=>"http://sumofus.org/wp-content/themes/pgm/"\
          "img/default-facebook.jpg"}],
        "email"=>[{
          "id"=>48617,
            "email_subject"=>"SumOfUs",
            "email_body"=>"SumOfUs is a global movement of consumers, "\
              "investors, and workers all around the world, standing together "\
              "to hold corporations accountable for their actions and forge "\
              "a new, sustainable and just path for our global economy. It's "\
              "not going to be fast or easy. But if enough of us come "\
              "together, we can make a real difference.\n{LINK}"}],
        "twitter"=>[{
          "id"=>48613,
            "twitter_message"=>"Twitter message 1 {LINK}"}, {
          "id"=>48614,
            "twitter_message"=>"Twitter message 2 {LINK}"}, {
          "id"=>48615,
            "twitter_message"=>"Twitter message 3 {LINK}"}]},
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
          "passed"=>"referrer_id"}
      }
    }

    assert result == expected_result
  end

  test "create twitter button with wrong button_template" do |data|
    data["button_template"] = "sp_fb_small"

    result = ShareProgress::Button.create(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  test "create twitter button with nil twitter_message" do |data|
    data["variants"]["twitter"][0]["twitter_message"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:twitter_message=>[:nil]}

    assert result == expected_result
  end

  test "create twitter button with empty twitter_message" do |data|
    data["variants"]["twitter"][0]["twitter_message"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:twitter_message=>[:empty]}

    assert result == expected_result
  end

  test "create twitter button with {LINK} not included in twitter_message" do |data|
    data["variants"]["twitter"][0]["twitter_message"] = "This is a content with no link"

    result = ShareProgress::Button.create(data)

    expected_result = {:twitter_message=>[:link_not_included]}

    assert result == expected_result
  end
end
