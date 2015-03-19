require "cutest"
require_relative "../lib/shareprogress"

# Monkeypath the communication with ShareProgress
module ShareProgressRequest
  def self.create_button(payload)
    return {
      "success"=>true,
      "response"=>[{
        "id"=>12136,
        "page_url"=>"http://sumofus.org/",
        "page_title"=>"My Email button name",
        "button_template"=>"sp_em_large",
        "share_button_html"=>"<div class='sp_12136 sp_em_large' ></div>",
        "found_snippet"=>false,
        "is_active"=>false,
        "variants"=>{
          "facebook"=>[{
            "id"=>48542,
            "facebook_title"=>"SumOfUs",
            "facebook_description"=>"SumOfUs is a global movement of "\
              "consumers, investors, and workers all around the world, standing "\
              "together to hold corporations accountable for their actions and "\
              "forge a new, sustainable and just path for our global economy. "\
              "It's not going to be fast or easy. B",
            "facebook_thumbnail"=>"http://sumofus.org/wp-content/themes/"\
              "pgm/img/default-facebook.jpg"}],
          "email"=>[{
            "id"=>48539,
              "email_subject"=>"Email subject 1!",
              "email_body"=>"Email body 1 {LINK}"}, {
            "id"=>48540,
              "email_subject"=>"Email subject 2!",
              "email_body"=>"Email body 2 {LINK}"}, {
            "id"=>48541,
              "email_subject"=>"Email subject 3!",
              "email_body"=>"Email body 3 {LINK}"}],
          "twitter"=>[{
            "id"=>48543,
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
      "message"=>nil
    }
  end
end

setup do
  {
    "key" => "123456",
    "page_url" => "http://sumofus.org/",
    "page_title" => "My Email button name",
    "auto_fill" => true,
    "button_template" => "sp_em_large",
    "variants" => {
      "email" => [
        {"email_subject" => "Email subject 1!",
          "email_body" => "Email body 1 {LINK}"},
        {"email_subject" => "Email subject 2!",
          "email_body" => "Email body 2 {LINK}"},
        {"email_subject" => "Email subject 3!",
          "email_body" => "Email body 3 {LINK}"}
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
  test "create email button successfully" do |data|
    result = ShareProgress::Button.create_button(data)

    expected_result = {
      "id"=>12136,
      "page_url"=>"http://sumofus.org/",
      "page_title"=>"My Email button name",
      "button_template"=>"sp_em_large",
      "share_button_html"=>"<div class='sp_12136 sp_em_large' ></div>",
      "found_snippet"=>false,
      "is_active"=>false,
      "variants"=>{
        "facebook"=>[{
          "id"=>48542,
            "facebook_title"=>"SumOfUs",
            "facebook_description"=>"SumOfUs is a global movement of "\
            "consumers, investors, and workers all around the world, "\
            "standing together to hold corporations accountable for their "\
            "actions and forge a new, sustainable and just path for our "\
            "global economy. It's not going to be fast or easy. B",
            "facebook_thumbnail"=>"http://sumofus.org/wp-content/themes/pgm/"\
            "img/default-facebook.jpg"}],
        "email"=>[{
          "id"=>48539,
            "email_subject"=>"Email subject 1!",
            "email_body"=>"Email body 1 {LINK}"}, {
          "id"=>48540,
            "email_subject"=>"Email subject 2!",
            "email_body"=>"Email body 2 {LINK}"}, {
          "id"=>48541,
            "email_subject"=>"Email subject 3!",
            "email_body"=>"Email body 3 {LINK}"}],
        "twitter"=>[{
          "id"=>48543,
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

  test "create email button with wrong button_template" do |data|
    data["button_template"] = "sp_tw_large"

    result = ShareProgress::Button.create_button(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  test "create email button with nil email_subject" do |data|
    data["variants"]["email"][0]["email_subject"] = nil

    result = ShareProgress::Button.create_button(data)

    expected_result = {:email_subject=>[:nil]}

    assert result == expected_result
  end

  test "create email button with empty email_subject" do |data|
    data["variants"]["email"][0]["email_subject"] = ""

    result = ShareProgress::Button.create_button(data)

    expected_result = {:email_subject=>[:empty]}

    assert result == expected_result
  end

  test "create email button with nil email_body" do |data|
    data["variants"]["email"][0]["email_body"] = nil

    result = ShareProgress::Button.create_button(data)

    expected_result = {:email_body=>[:nil]}

    assert result == expected_result
  end

  test "create email button with empty email_body" do |data|
    data["variants"]["email"][0]["email_body"] = ""

    result = ShareProgress::Button.create_button(data)

    expected_result = {:email_body=>[:empty]}

    assert result == expected_result
  end

  test "create email button with {LINK} not included in email_body" do |data|
    data["variants"]["email"][0]["email_body"] = "This is a content with no link"

    result = ShareProgress::Button.create_button(data)

    expected_result = {:email_body=>[:link_not_included]}

    assert result == expected_result
  end
end
