require "pagy/extras/bootstrap"

Pagy::DEFAULT[:items] = Settings.pagy.items_per_page

Pagy::DEFAULT.freeze
