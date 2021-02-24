require 'uart'

class Remote
  attr_accessor :uart
  
  def initializer(serial: '/dev/ttyS0', baud: 300, mode: '8N1')
    self.uart = UART.new serial, baud, mode
  end
end
