# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Notification < ApplicationModel
  include ChecksHtmlSanitized

  sanitized_html :note
end
