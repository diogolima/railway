require 'dry/monads'

class CarDealership
  include Dry::Monads[:result]

  def initialize
    @available_models = %w[Corolla Yaris Prius RAV4]
    @available_colors = %w[red black blue white]
    @nearby_cities = %w[Berlin Porto Barcelona]
  end

  def deliver_car(params)
    authenticate(**params).bind do |authenticate_params|
      check_year(**authenticate_params).bind do |year_params|
        check_model(**year_params).bind do |model_params|
          check_color(**model_params).bind do |color_params|
            check_city(**color_params).bind do |city_params|
              Success("A new #{city_params[:year]} #{city_params[:color]} #{city_params[:model]} car is on the way to #{city_params[:city]}!")
            end
          end
        end
      end
    end
  end

  private

  def authenticate(**input)
    user_id = 123
    Success(**input, user_id: user_id)
  end

  def check_year(year:, **input)
    if year.to_i >= 2000
      Success(**input, year: year)
    else
      Failure(:invalid_year)
    end
  end

  def check_model(model:, **input)
    if @available_models.include?(model)
      Success(**input, model: model)
    else
      Failure(:invalid_model)
    end
  end

  def check_color(color:, **input)
    if @available_colors.include?(color)
      Success(**input, color: color)
    else
      Failure(:invalid_color)
    end
  end

  def check_city(city:, **input)
    if @nearby_cities.include?(city)
      Success(**input, city: city)
    else
      Failure(:invalid_deliver_city)
    end
  end
end
