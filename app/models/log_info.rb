class LogInfo < ApplicationRecord
  enum log_type: {
    info: 'info',
    error: 'error'
  }
end
