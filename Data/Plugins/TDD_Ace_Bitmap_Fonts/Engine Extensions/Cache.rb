module Cache
  #--------------------------------------------------------------------------
  # * Get Bitmap Font
  #--------------------------------------------------------------------------
  def self.bitmap_font(filename)
    load_bitmap("#{TDD::ABF::SETTINGS::FOLDER}/", filename)
  end
end