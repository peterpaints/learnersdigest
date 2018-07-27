# frozen_string_literal: true

require './microlearn'

require_all 'app'

use AuthController
use TopicsController
use PagesController
run App
