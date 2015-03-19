require "requests"

module ShareProgressRequest
  def self.create_button(payload)
    response = Requests.request("POST",
      "https://run.shareprogress.org/api/v1/buttons/update",
      data: JSON.dump(payload),
      headers: { "Content-Type" => "application/json" }
    )

    return JSON.parse(response.body)
  end
end
