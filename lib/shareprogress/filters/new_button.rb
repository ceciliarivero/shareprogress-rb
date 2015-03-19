class NewButton < Scrivener
  attr_accessor :key, :page_url, :button_template, :page_title
  attr_accessor :auto_fill, :advanced_options, :variants

  def validate
    assert_present :key
    assert_url :page_url

    assert_member :button_template, %w{sp_em_small sp_em_large sp_tw_small
      sp_tw_large sp_fb_small sp_fb_large}

    assert_present :variants

    if auto_fill
      assert auto_fill == false || auto_fill == true, [:auto_fill, :not_boolean]
    end

    if advanced_options
      if advanced_options["automatic_traffic_routing"]
        assert advanced_options["automatic_traffic_routing"] == false ||
          advanced_options["automatic_traffic_routing"] == true, [:automatic_traffic_routing, :not_boolean]
      end

      if advanced_options["buttons_optimize_actions"]
        assert advanced_options["buttons_optimize_actions"] == false ||
          advanced_options["buttons_optimize_actions"] == true, [:buttons_optimize_actions, :not_boolean]
      end

      if advanced_options["customize_params"]
        cp = advanced_options["customize_params"]

        assert !cp["param"].nil?, [:param, :not_present]
        assert !cp["e"].nil?, [:e, :not_present]
        assert !cp["f"].nil?, [:f, :not_present]
        assert !cp["t"].nil?, [:t, :not_present]
        assert !cp["o"].nil?, [:o, :not_present]
      end

      if advanced_options["id_pass"]
        ip = advanced_options["id_pass"]

        assert !ip["id"].nil?, [:id, :not_present]
        assert !ip["passed"].nil?, [:passed, :not_present]
      end
    end
  end
end
