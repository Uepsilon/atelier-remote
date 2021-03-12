# frozen_string_literal: true

require 'uart'

class Remote
  class Error < StandardError; end

  attr_accessor :serial, :baud, :mode

  CMD_LIST = {
    number1: [48, 57, 54],
    number2: [48, 57, 53],
    number3: [48, 57, 52],
    number4: [48, 57, 51],
    number5: [48, 57, 50],
    number6: [48, 57, 62],
    number7: [48, 57, 61],
    number8: [48, 57, 60],
    number9: [48, 57, 59],
    number0: [48, 57, 58],
    prev_program: [48, 57, 55],
    next_program: [48, 57, 56],
    tape1: [48, 57, 63],
    tape2: [48, 57, 64],
    memo_check: [48, 58, 49],
    next: [48, 58, 50],
    prev: [48, 58, 51],
    stop: [48, 58, 52],
    pause: [48, 58, 53],
    start: [48, 58, 54],
    low_bass: [48, 58, 56],
    high_blend: [48, 58, 57],
    reset: [48, 58, 58],
    set: [48, 58, 59],
    memo: [48, 58, 60],
    space: [48, 58, 61],
    record: [48, 58, 62],
    man_tune_inc: [48, 58, 63],
    man_tune_dec: [48, 58, 64],
    bass_center: [48, 59, 49],
    speaker: [48, 59, 50],
    control: [48, 59, 51],
    mono: [48, 59, 52],
    source2: [48, 59, 53],
    bass: [48, 59, 61],
    bass_inc: [48, 59, 55],
    bass_dec: [48, 59, 56],
    balance_center: [48, 59, 57],
    balance_inc: [48, 59, 58],
    balance_dec: [48, 59, 59],
    treble: [48, 59, 60],
    treble_inc: [48, 59, 63],
    treble_dec: [48, 59, 64],
    loudness: [48, 59, 62],
    filter_20hz: [48, 60, 49],
    power: [48, 60, 50],
    vol2_inc: [48, 60, 51],
    vol2_dec: [48, 60, 52],
    mute: [48, 60, 53],
    equalizer: [48, 60, 54],
    vol1_inc: [48, 60, 55],
    vol1_dec: [48, 60, 56],
    source_am: [48, 60, 57],
    source_tape: [48, 60, 58],
    source_tv: [48, 60, 59],
    source_fm: [48, 60, 60],
    source_phono: [48, 60, 61],
    source_cd: [48, 60, 62],
    speaker1: [48, 60, 63],
    speaker2: [48, 60, 64]
  }.freeze

  def initialize(serial:, baud:, mode:)
    self.serial = serial
    self.baud = baud
    self.mode = mode
  end

  def call(cmd)
    cmd = cmd.to_sym unless cmd.is_a?(Symbol)

    unless CMD_LIST.keys.include?(cmd)
      raise Error, "`#{cmd}` is not a valid command, see /commands for a list of commands"
    end

    UART.open(serial, baud, mode) do |uart|
      uart.write(CMD_LIST[cmd].map(&:chr).join)
    end
  end
end
