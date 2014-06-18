class CheckBrackets

  MATCHING_BRACKETS = {')' => '(', ']' => '[', '}' => '{'}

  attr_reader :input_string
  attr_accessor :open_brackets
  attr_accessor :cycle_break

  def initialize(input_string)
    @input_string = input_string
    @open_brackets = []
    @cycle_break = false
    start
  end

  def matching_all?
    return @open_brackets.empty? && !@cycle_break
  end


  private

  def start
    begin
      @input_string.each_char do |char|
        if MATCHING_BRACKETS.values.include?(char)
          @open_brackets.push(char)
        elsif MATCHING_BRACKETS.keys.include?(char)
          @open_brackets.empty? && raise(BreakCycle) # no opens brackets before
          (@open_brackets.last == MATCHING_BRACKETS[char]) || raise(BreakCycle) # there aren't matching open brackets on the top of the stack
          @open_brackets.pop
        end
      end
    rescue BreakCycle
      @cycle_break = true
    end


  end

  class BreakCycle < StandardError

  end


end


#check = CheckBrackets.new('()(){{')
#puts "check.matching_all?: #{check.matching_all?}"
#puts "check.open_brackets: #{check.open_brackets}"
#puts "check.cycle_break: #{check.cycle_break}"

require 'rspec'

describe CheckBrackets do
  it "return true if empty string is given" do
    expect(CheckBrackets.new('').matching_all?).to eq(true)
  end

  it "cycle_break is true if the first char is a closed bracket or found unmatched bracket before end of string" do
    expect(CheckBrackets.new(')').cycle_break).to eq(true)
    expect(CheckBrackets.new('()][]))').cycle_break).to eq(true)
  end

  it "return false if the first char is a closed bracket" do
    expect(CheckBrackets.new('}').matching_all?).to eq(false)
  end

  it "open_brackets is empty if unmatched close bracket found after all matched brackets" do
    expect(CheckBrackets.new('{}[]()]').open_brackets).to eq([])
  end

end

rspec check_brackets.rb 
....

Finished in 0.00196 seconds
4 examples, 0 failures





