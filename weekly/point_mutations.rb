require 'pry'

class DNA

  def initialize(strand)
    @dna = strand
  end

  def hamming_distance(new_strand)
    new_strand = new_strand.chars
    dna = @dna.chars
    dna = (dna.size <= new_strand.size) ? dna : dna.take(new_strand.size)
    dna.select.each_with_index {|protein, idx| protein != new_strand[idx]}.count
  end



end