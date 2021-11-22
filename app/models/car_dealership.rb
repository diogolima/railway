require 'dry/monads'

class CarDealership
  include Dry::Monads::Result::Mixin

  def initialize
    @available_models = %w[Avalon Camry Corolla Venza]
    @available_colors = %w[red black blue white]
    @nearby_cities = %w[Austin Chicago Seattle]
  end

  def delivery_car(year, model, color, city)
    check_year(year).bind do |_|
      check_model(model).bind do |_|
        check_color(color).bind do |_|
          check_city(city).bind do |_|
            Success("A new #{year} #{color} #{model} car is on the way to #{city}!")
          end
        end
      end
    end
    #
    # yield check_year(year)
    # yield check_model(model)
    # yield check_color(color)
    # yield check_city(city)
  end

  def check_year(year)
    if year.to_i > 2000
      Success('Cars of this year are available')
    else
      Failure(:invalid_year)
    end
  end

  def check_model(model)
    if @available_models.include?(model)
      Success('This model is available')
    else
      Failure(:invalid_model)
    end
  end

  def check_color(color)
    if @available_colors.include?(color)
      Success('This color is available')
    else
      Failure(:invalid_color)
    end
  end

  def check_city(city)
    if @nearby_cities.include?(city)
      Success('This city is nearby and we can deliver')
    else
      Failure(:invalid_city)
    end
  end
end
