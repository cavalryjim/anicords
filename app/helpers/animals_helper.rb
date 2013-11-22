module AnimalsHelper
  
  def documents_legend_title(number)
    pluralize(number, 'document') + ' uploaded'
  end
  
  def pedigree_label(animal)
    if animal.pedigree.file
      html = label_tag('pedigree') + link_to(animal.pedigree.file.filename, animal.pedigree.url, target: '_blank')
    end
    
  end
  
  def feeding_frequency_options
    [
      ['Once a day', 1],
      ['2 x daily', 2],
      ['3 x daily', 3],
      ['4 x daily', 4]
    ]
  end
  
end
