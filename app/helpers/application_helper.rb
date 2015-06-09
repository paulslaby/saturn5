module ApplicationHelper

  def flash_class type
    case type.to_s

      when 'success'
        'success'
      when 'error'
        'danger'
      when 'warning'
        'warning'
      else
        # when 'info', 'notice', 'success'
        'info'
    end
  end


  # avoids exception on nil. returns empty string instead
  def localize(*args)
    return '' if args[0].nil?
    return t('boolean.true') if args[0].is_a? TrueClass
    return I18n.t('boolean.false') if args[0].is_a? FalseClass
    I18n.localize(*args)
  end
  alias :l :localize
end
