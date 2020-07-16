require 'rubygems'

require 'google/cloud/vision'

images = [
  'web_detection/aiya000.jpg',
  'web_detection/ishikawa.jpg',
  'web_detection/yassu.png',
  'web_detection/yasuda.png',
]

image_annotator = Google::Cloud::Vision.image_annotator

images.each do |image|
  puts '- - - - -'
  puts "For #{image}:"
  result = image_annotator.web_detection image: image, max_results: 15

  puts 'Fully matched images:'
  result.responses.each do |response|
    response.web_detection.full_matching_images.each do |match|
      puts match.url
    end
  end

  puts '---'

  puts 'Partially matched images'
  result.responses.each do |response|
    response.web_detection.partial_matching_images.each do |match|
      puts match.url
    end
  end

  puts ''
end
