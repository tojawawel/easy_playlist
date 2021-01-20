module NotSupportedCharacters
    CHARACTERS_TO_SUBSTITUTE = {
      'ę' => 'e',
      'Ę' => 'E',
      'ó' => 'o',
      'Ó' => 'O',
      'ą' => 'a',
      'Ą' => 'A',
      'ś' => 's',
      'Ś' => 'S',
      'ł' => 'l',
      'Ł' => 'L',
      'ż' => 'z',
      'Ż' => 'Z',
      'ź' => 'z',
      'Ź' => 'Z',
      'ć' => 'c',
      'Ć' => 'C',
      'ń' => 'n',
      'Ń' => 'N'
    }.freeze
end