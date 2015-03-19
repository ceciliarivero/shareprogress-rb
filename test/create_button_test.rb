require "cutest"
require_relative "../lib/shareprogress"

# Monkeypath the communication with ShareProgress
module ShareProgress
  module Button
    def self.request(method, payload)
      return {
        "success"=>true,
        "response"=>[{
          "id"=>12136,
          "page_url"=>"http://sumofus.org/",
          "page_title"=>"My button name",
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
end

setup do
  {
    "key" => "123456",
    "page_url" => "http://sumofus.org/",
    "page_title" => "My button name",
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
  test "create button successfully" do |data|
    result = ShareProgress::Button.create(data)

    expected_result = {
      "id"=>12136,
      "page_url"=>"http://sumofus.org/",
      "page_title"=>"My button name",
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

  # key
  test "create button with nil key" do |data|
    data["key"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:key=>[:not_present]}

    assert result == expected_result
  end

  test "create button with empty key" do |data|
    data["key"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:key=>[:not_present]}

    assert result == expected_result
  end

  # page_url
  test "create button with nil page_url" do |data|
    data["page_url"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:page_url=>[:not_url]}

    assert result == expected_result
  end

  # page_url
  test "create button with empty page_url" do |data|
    data["page_url"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:page_url=>[:not_url]}

    assert result == expected_result
  end

  # page_title
  test "create button with nil page_title" do |data|
    data["page_title"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:page_title=>[:not_present]}

    assert result == expected_result
  end

  # page_title
  test "create button with empty page_title" do |data|
    data["page_title"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:page_title=>[:not_present]}

    assert result == expected_result
  end

  # button_template
  test "create button with nil button_template" do |data|
    data["button_template"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  test "create button with empty button_template" do |data|
    data["button_template"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  test "create button with wrong button_template" do |data|
    data["button_template"] = "wrong_button_template"

    result = ShareProgress::Button.create(data)

    expected_result = {:button_template=>[:not_valid]}

    assert result == expected_result
  end

  # auto_fill
  test "create button with not boolean auto_fill" do |data|
    data["auto_fill"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:auto_fill=>[:not_boolean]}

    assert result == expected_result
  end

  # variants
  test "create button with no variants" do |data|
    data["variants"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:variants=>[:not_present]}

    assert result == expected_result
  end

  # advanced_options
  test "create button with not boolean automatic_traffic_routing" do |data|
    data["advanced_options"]["automatic_traffic_routing"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:automatic_traffic_routing=>[:not_boolean]}

    assert result == expected_result
  end

  test "create button with not boolean buttons_optimize_actions" do |data|
    data["advanced_options"]["buttons_optimize_actions"] = ""

    result = ShareProgress::Button.create(data)

    expected_result = {:buttons_optimize_actions=>[:not_boolean]}

    assert result == expected_result
  end

  test "create button with no param in customize_params" do |data|
    data["advanced_options"]["customize_params"]["param"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:param=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no e in customize_params" do |data|
    data["advanced_options"]["customize_params"]["e"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:e=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no f in customize_params" do |data|
    data["advanced_options"]["customize_params"]["f"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:f=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no t in customize_params" do |data|
    data["advanced_options"]["customize_params"]["t"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:t=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no o in customize_params" do |data|
    data["advanced_options"]["customize_params"]["o"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:o=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no id in id_pass" do |data|
    data["advanced_options"]["id_pass"]["id"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:id=>[:not_present]}

    assert result == expected_result
  end

  test "create button with no passed in id_pass" do |data|
    data["advanced_options"]["id_pass"]["passed"] = nil

    result = ShareProgress::Button.create(data)

    expected_result = {:passed=>[:not_present]}

    assert result == expected_result
  end
end
