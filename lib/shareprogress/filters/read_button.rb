class ReadButton < Scrivener
  attr_accessor :key, :id

  def validate
    assert_present :key
    assert_present :id
  end
end
