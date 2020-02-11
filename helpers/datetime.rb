def time_decimal(time_to_convert)
  date_object = DateTime.parse(time_to_convert)
  return date_object.hour + date_object.minute.to_f/60
end
