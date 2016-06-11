class House

def self.recite

  verse = (1..pieces.size).map {|n| pieces.last(n)}
                          .map {|pieces| combine_pieces(pieces)}
                          .join("\n\n")
  verse + "\n"
  # (1..pieces.size).each do |lines|
  #   song += combine_pieces(pieces.last(lines))
  #   if lines == pieces.size
  #     song += "\n"
  #   else
  #     song += "\n\n"
  #   end
  # end
  #song
end

def self.combine_pieces(pieces)
  #line = 'This is '
  paragraph = pieces.map {|piece| piece.join("\n")}.join(' ')
  "This is #{paragraph}."
  # pieces.each do |piece|
  #   line += piece[0] 
  #   line += "\n"  if piece[1]
  #   line += piece[1] + ' ' if piece[1]
  # end
  # line + '.'
end

def self.pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end


puts House.recite