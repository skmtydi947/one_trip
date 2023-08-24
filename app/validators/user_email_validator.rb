class UserEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.include?('@')
      record.errors.add attribute, (options[:message] || 'には＠を含めてください')
    end
  end
end
