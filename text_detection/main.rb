require 'rubygems'

require 'google/cloud/vision'

image_annotator = Google::Cloud::Vision.image_annotator
result = image_annotator.text_detection images: [
  './text_detection/hitori.jpg',
  './text_detection/super-pc.jpg',
  './text_detection/sushi-bar.jpg',
  './text_detection/teco.jpg',
]

for response in result.responses do
  puts '---'
  for text_annotation in response.text_annotations do
    puts text_annotation.description
  end
end
