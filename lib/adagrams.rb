def draw_letters
  letters = {
    "A" => 9,
    "B" => 2,
    "C" => 2,
    "D" => 4,
    "E" => 12,
    "F" => 2,
    "G" => 3,
    "H" => 2,
    "I" => 9,
    "J" => 1,
    "K" => 1,
    "L" => 4,
    "M" => 2,
    "N" => 6,
    "O" => 8,
    "P" => 2,
    "Q" => 1,
    "R" => 6,
    "S" => 4,
    "T" => 6,
    "U" => 4,
    "V" => 2,
    "W" => 2,
    "X" => 1,
    "Y" => 2,
    "Z" => 1
  }

  #Creates the array of all the letters available to pick
  letter_probability = []
  letters.each do |key,value|
    until value == 0
      letter_probability << key
      value -= 1
    end
  end

  #Select letters and replace with 0 once they are pulled
  your_hand = []
  count = 0
  while count < 10 do
    index = rand(0...letter_probability.length)
    if letter_probability[index] != 0
      your_hand << letter_probability [index]
      count += 1
      letter_probability[index] = 0
    end
  end
  return your_hand
end

def uses_available_letters?(input, letters_in_hand)
  input = input.upcase.split("")
  if input.length > letters_in_hand.length
    return false
  else
    input.each do |letter|
      if input.count(letter) > letters_in_hand.count(letter)
        return false
      else
        return true
      end
    end
  end
end
