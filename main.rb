require 'rubygems'

require 'google/cloud/vision'

image_annotator = Google::Cloud::Vision.image_annotator
result = image_annotator.label_detection image: './me.jpg'

for response in result.responses do
  puts '---'
  for label_annotation in response.label_annotations do
    puts label_annotation.description
  end
end
