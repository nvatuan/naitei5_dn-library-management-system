require "pagy/extras/bootstrap"

Pagy::DEFAULT[:items] = Settings.pagy.items_per_page
Pagy::DEFAULT[:size] = [3,2,2,3]
Pagy::DEFAULT.freeze
