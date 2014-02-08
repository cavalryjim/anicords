module AnimalsHelper
  
  def documents_legend_title(number)
    pluralize(number, 'document') + ' uploaded'
  end
  
  def neutered_term(gender)
    (gender == 'female') ? 'spayed' : 'neutered'
  end
  
  def pedigree_label(animal)
    if animal.pedigree.file
      html = label_tag('pedigree') + link_to(animal.pedigree.file.filename, animal.pedigree.url, target: '_blank')
    end
    
  end
  
  def complete_profile_message(animal)
    animal.name + "s' profile is only " + animal.profile_completion + "% complete."
  end
  
  def feeding_frequency_options
    [
      ['Once a day', 1],
      ['2 x daily', 2],
      ['3 x daily', 3],
      ['4 x daily', 4]
    ]
  end
  
  def animal_sizes
    [ 'small', 'medium', 'large', 'x-large' ]
  end
  
end
