# frozen_string_literal: true

require 'view/game/actionable'

module View
  module Game
    class Choose < Snabberb::Component
      include Actionable

      def render
        choice_buttons = @game.round.active_step.choices.map do |choice|
          click = lambda do
            process_action(Engine::Action::Choose.new(
              @game.current_entity,
              choice: choice,
            ))
          end

          props = {
            style: {
              width: 'calc(17.5rem/6)',
              padding: '0.2rem 0',
            },
            on: { click: click },
          }
          h('button.small', props, choice)
        end

        div_class = choice_buttons.size < 5 ? '.inline' : ''
        h(:div, [
          h("div#{div_class}", { style: { marginTop: '0.5rem' } }, "#{@game.round.active_step.choice_name}:"),
          *choice_buttons,
        ])
      end
    end
  end
end
