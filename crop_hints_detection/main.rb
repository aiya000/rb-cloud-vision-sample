require 'rubygems'

require 'google/cloud/vision'
require 'rmagick'

def main()
  image_annotator = Google::Cloud::Vision.image_annotator
  images = [
    'crop_hints_detection/lala.jpg',
    'crop_hints_detection/lala.jpg.result.jpg',
    'crop_hints_detection/lala2.jpg',
    'crop_hints_detection/me.jpg',
    'crop_hints_detection/me.jpg.result.jpg',
    'crop_hints_detection/neko.jpg',
    'crop_hints_detection/person.jpg',
    'crop_hints_detection/person.jpg.result.jpg',
    'crop_hints_detection/side-faces.jpg',
    'crop_hints_detection/small-faces.jpg',
    'crop_hints_detection/too-many-persons.jpg',
    'crop_hints_detection/us.jpg',
  ]

  images.each do |image|
    puts "let's parse for #{image}"
    result = image_annotator.crop_hints_detection image: image

    result.responses.each do |response|
      hints = response.crop_hints_annotation.crop_hints

      hints.each do |hint|
        hint.bounding_poly.vertices.each do |bound|
          puts "#{bound.x}, #{bound.y}"
        end
      end

      hints.each do |hint|
        dist = "#{image}.result.jpg"
        puts "output: #{dist}"

        write_square_to_image image, dist, hint
      end
    end
  end
end

def write_square_to_image(src, dist, crop_hints)
  x1 = crop_hints.bounding_poly.vertices[0].x.to_i
  y1 = crop_hints.bounding_poly.vertices[0].y.to_i
  x2 = crop_hints.bounding_poly.vertices[2].x.to_i
  y2 = crop_hints.bounding_poly.vertices[2].y.to_i

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
