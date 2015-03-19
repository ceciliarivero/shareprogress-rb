require "scrivener"
require_relative "shareprogress_request"

Dir["./filters/*.rb"].each  { |rb| require rb }

class ShareProgress
  def self.create_button(data)
    # Validates the input (a hash) to send a POST request to
    # ShareProgress to create a share button. The result could be:
    # a) A hash containing the information of the created button or,
    # b) An Error message from ShareProgress (i.e. 'Bad API key').

    # Arguments received:
    # data: A hash containing all the info about the button. For example:
    # {
    #   "key" => "123456",
    #   "page_url" => "http://sumofus.org/",
    #   "page_title" => "My button name",
    #   "auto_fill" => true,
    #   "button_template" => "sp_em_large",
    #   "variants" => {
    #     "email" => [
    #       {"email_subject" => "Email subject 1!",
    #         "email_body" => "Email body 1 {LINK}"},
    #       {"email_subject" => "Email subject 2!",
    #         "email_body" => "Email body 2 {LINK}"},
    #       {"email_subject" => "Email subject 3!",
    #         "email_body" => "Email body 3 {LINK}"}
    #       ]
    #     },
    #   "advanced_options" => {
    #     "automatic_traffic_routing" => true,
    #     "buttons_optimize_actions" => true,
    #     "customize_params" => {
    #       "param" => "param_to_use",
    #       "e" => "email_source",
    #       "f" => "facebook_source",
    #       "t" => "twitter_source",
    #       "o" => "dark_social_source"
    #     },
    #     "id_pass" => {
    #     "id" => "id",
    #     "passed" => "referrer_id"
    #     }
    #   }
    # }

    # Example of a successful response:
    # {
    #   "id"=>12136,
    #   "page_url"=>"http://sumofus.org/",
    #   "page_title"=>"My button name",
    #   "button_template"=>"sp_em_large",
    #   "share_button_html"=>"<div class='sp_12136 sp_em_large' ></div>",
    #   "found_snippet"=>false,
    #   "is_active"=>false,
    #   "variants"=>{
    #     "facebook"=>[{
    #       "id"=>48542,
    #         "facebook_title"=>"SumOfUs",
    #         "facebook_description"=>"SumOfUs is a global movement of "\
    #         "consumers, investors, and workers all around the world, "\
    #         "standing together to hold corporations accountable for their "\
    #         "actions and forge a new, sustainable and just path for our "\
    #         "global economy. It's not going to be fast or easy. B",
    #         "facebook_thumbnail"=>"http://sumofus.org/wp-content/themes/pgm/"\
    #         "img/default-facebook.jpg"}],
    #     "email"=>[{
    #       "id"=>48539,
    #         "email_subject"=>"Email subject 1!",
    #         "email_body"=>"Email body 1 {LINK}"}, {
    #       "id"=>48540,
    #         "email_subject"=>"Email subject 2!",
    #         "email_body"=>"Email body 2 {LINK}"}, {
    #       "id"=>48541,
    #         "email_subject"=>"Email subject 3!",
    #         "email_body"=>"Email body 3 {LINK}"}],
    #     "twitter"=>[{
    #       "id"=>48543,
    #       "twitter_message"=>"SumOfUs {LINK}"}]},
    #   "advanced_options"=>{
    #     "automatic_traffic_routing"=>true,
    #     "buttons_optimize_actions"=>true,
    #     "customize_params"=>{
    #       "param"=>"param_to_use",
    #       "e"=>"email_source",
    #       "f"=>"facebook_source",
    #       "t"=>"twitter_source",
    #       "o"=>"dark_social_source"},
    #     "id_pass"=>{
    #       "id"=>"id",
    #       "passed"=>"referrer_id"}}
    # }
    button = NewButton.new(data)

    if button.valid?
      button_variants = button.variants.merge(button_template: button.button_template)

      if button.variants["email"]
        variants = NewEmailVariants.new(button_variants)
      elsif button.variants["twitter"]
        variants = NewTwitterVariants.new(button_variants)
      elsif button.variants["facebook"]
        variants = NewFacebookVariants.new(button_variants)
      end

      if variants.valid?
        # send request to ShareProgress to create a button
        begin
          request = ShareProgressRequest.create_button(button.attributes)
          request["response"][0]
        rescue Requests::Error => e
          JSON.parse(e.response.body)["message"]
        end
      else
        variants.errors
      end

    else
      button.errors
    end

  end
end