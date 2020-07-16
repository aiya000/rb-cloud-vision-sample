require 'rubygems'

require 'google/cloud/vision'
require 'rmagick'

def main()
  image_annotator = Google::Cloud::Vision.image_annotator
  images = [
    './face_detection/lala.jpg',
    './face_detection/me.jpg',
    './face_detection/person.jpg',
  ]

  images.each do |image|
    puts "let's parse for #{image}"
    result = image_annotator.face_detection image: image

    result.responses.each do |response|
      if response.face_annotations.size < 1
        puts 'No faces recognized.'
        break
      end

      response.face_annotations.each do |face_annotation|
        dist = "#{image}.result.jpg"
        puts "output: #{dist}"

        write_square_to_image image, dist, face_annotation
      end
    end
  end
end

def write_square_to_image(src, dist, face_annotation)
  x1 = face_annotation.bounding_poly.vertices[0].x.to_i
  y1 = face_annotation.bounding_poly.vertices[0].y.to_i
  x2 = face_annotation.bounding_poly.vertices[2].x.to_i
  y2 = face_annotation.bounding_poly.vertices[2].y.to_i

  photo = Magick::Image.read(src).first
  draw = Magick::Draw.new
  draw.stroke = 'green'
  draw.stroke_width 5
  draw.fill_opacity 0
  draw.rectangle x1, y1, x2, y2
  draw.draw photo

  photo.write dist
end

main
