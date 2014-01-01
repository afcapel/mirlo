module Mirlo
  class DoubleMoonDataSet < Dataset
    attr_reader :radius, :width, :distance

    DEFAULT_RADIUS   = 10
    DEFAULT_WIDTH    = 6
    DEFAULT_DISTANCE = 2

    UPPER_MOON = [1]
    LOWER_MOON = [0]

    def initialize(n_points: 500, radius: DEFAULT_RADIUS, width: DEFAULT_WIDTH, distance: DEFAULT_DISTANCE)
      feature_names = ['x', 'y']
      title = "Double Moon Dataset with radius:=#{radius}, width:=#{width}, distance:=#{distance}"
      @radius, @width, @distance = radius, width, distance
      samples = n_points.times.collect { random_point }

      labels = {
        UPPER_MOON => 'Upper moon',
        LOWER_MOON => 'Lower moon'
      }

      super(samples: samples, feature_names: feature_names, title: title, labels: labels)
    end

    def random_point
      angle_coord  = rand * Math::PI
      radial_coord = radius + width * rand(-0.5..0.5)

      target = rand(2) == 1 ? UPPER_MOON : LOWER_MOON

      if target == UPPER_MOON
        x = radial_coord * Math.cos(angle_coord)
        y = radial_coord * Math.sin(angle_coord)
      else
        x = radial_coord * Math.cos(angle_coord) + radius
        y = - radial_coord * Math.sin(angle_coord) - distance
      end

      SampleWithBias.new(target: target, features: [x, y])
    end
  end
end