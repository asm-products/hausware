module AutoPermalink
  
  # Usage:
  # def autofill_permalink_if_blank
  #   return true unless self.permalink.blank? # Bypass if permalink is already set
  #   self.permalink = AutoPermalink::cleaned_deduped_permalink(self.class, self.name)
  # end
  
  # Autofix duplication of permalinks
  def self.cleaned_deduped_permalink(klass, candidate_permalink, column_name = 'permalink')
    candidate_permalink = cleaned_permalink(candidate_permalink)
    n = klass.where(column_name => candidate_permalink).count

    if n > 0
      links = klass.where(["#{column_name} LIKE ?", "#{candidate_permalink}%"]).order(:id)

      number = 0

      links.each_with_index do |link, index|
        if link.send(column_name) =~ /#{candidate_permalink}-\d*\.?\d+?$/
          new_number = link.send(column_name).match(/-(\d*\.?\d+?)$/)[1].to_i
          number = new_number if new_number > number
        end
      end
      return resolve_duplication(candidate_permalink, number + 1)
    else
      return candidate_permalink
    end
  end

  def self.resolve_duplication(permalink, number)
    "#{permalink}-#{number}"
  end
  
  def self.cleaned_permalink(str)
    # Not especially nice, but other things (like PermalinkFu plugin and iconv
    # in general) didn't work properly (some chars were incorrectly converted to
    # '-'
    permalink = str.dup.downcase
    permalink = permalink.strip
    permalink.gsub!(/[\/\.\:\@]/, " ")
    permalink.gsub!(/[àáâãäåāăÀÁÂÃÄÅĀĂ]/, 'a')
    permalink.gsub!(/æÆ/, 'ae')
    permalink.gsub!(/[ďđĎĐ]/, 'd')
    permalink.gsub!(/[çćčĉċÇĆČĈĊ]/, 'c')
    permalink.gsub!(/[èéêëēęěĕėÈÉÊËĒĘĚĔĖ]/, 'e')
    permalink.gsub!(/ƒƑ/, 'f')
    permalink.gsub!(/[ĝğġģĜĞĠĢ]/, 'g')
    permalink.gsub!(/[ĥħĤĦ]/, 'h')
    permalink.gsub!(/[ììíîïīĩĭÌÌÍÎÏĪĨĬ]/, 'i')
    permalink.gsub!(/[įıĳĵĮIĲĴ]/, 'j')
    permalink.gsub!(/[ķĸĶĸ]/, 'k')
    permalink.gsub!(/[łľĺļŀŁĽĹĻĿ]/, 'l')
    permalink.gsub!(/[ñńňņŉŋÑŃŇŅŉŊ]/, 'n')
    permalink.gsub!(/[òóôõöøōőŏŏÒÓÔÕÖØŌŐŎŎ]/, 'o')
    permalink.gsub!(/œŒ/, 'oe')
    permalink.gsub!(/ąĄ/, 'q')
    permalink.gsub!(/[ŕřŗŔŘŖ]/, 'r')
    permalink.gsub!(/[śšşŝșŚŠŞŜȘ]/, 's')
    permalink.gsub!(/[ťţŧțŤŢŦȚ]/, 't')
    permalink.gsub!(/[ùúûüūůűŭũųÙÚÛÜŪŮŰŬŨŲ]/, 'u')
    permalink.gsub!(/ŵŴ/, 'w')
    permalink.gsub!(/[ýÿŷÝŸŶ]/, 'y')
    permalink.gsub!(/[žżźŽŻŹ]/, 'z')
    permalink.gsub!(/[^a-z0-9_-]/i, '-')
    permalink.gsub!(/_+/, '_')
    permalink.gsub!(/ +/, '-')
    permalink.gsub!(/^-+/, '')
    permalink.gsub!(/-+/, '-')
    permalink
  end
  
end