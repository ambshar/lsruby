
class RunLengthEncoding

  def self.encode(string)
    output = string.encode("utf-8").scan(/((\s|\w|\W)\2*)/).map(&:first)
    output = output.map do |e|
      e.size == 1 ? e[0] : e.size.to_s + e[0]
    end
    output.join
  end

  def self.decode(string)
    output = string.scan(/(\d*)([A-Za-z\s\W])/)
    output = output.map do |code|
      code[0].to_i == 0 ? code[1] : code[1]*code[0].to_i
    end
    output.join
  end
end

p RunLengthEncoding.encode('⏰⚽⚽⚽⭐⭐⏰')

p RunLengthEncoding.decode('⏰3⚽2⭐⏰')
