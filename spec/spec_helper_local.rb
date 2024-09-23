# frozen_string_literal: true

dir = __dir__
Dir["#{dir}/shared_examples/**/*.rb"].sort.each { |f| require f }

def platforms
  {
    'RedHat-8' => {
      python_version: '3',
      pip_provider: 'pip3',
      venv_python_version: '3.6'
    },
    'RedHat-9' => {
      python_version: '3',
      pip_provider: 'pip3',
      venv_python_version: '3.9'
    },
    'Debian-11' => {
      python_version: '3',
      pip_provider: 'pip',
      venv_python_version: 'system'
    },
    'Debian-20.04' => {
      python_version: '3',
      pip_provider: 'pip',
      venv_python_version: 'system'
    },
    'Debian-22.04' => {
      python_version: '3',
      pip_provider: 'pip',
      venv_python_version: 'system'
    }
  }
end
