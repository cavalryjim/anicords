module AnimalsHelper
  
  def documents_legend_title(number)
    pluralize(number, 'document') + ' uploaded'
  end
  
  def pedigree_label(animal)
    if animal.pedigree.file
      html = label_tag('pedigree') + link_to(animal.pedigree.file.filename, animal.pedigree.url, target: '_blank')
    end
    
  end
  
end
