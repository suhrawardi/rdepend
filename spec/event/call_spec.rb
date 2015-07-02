require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event::Call do

  describe '.initialize' do

    let(:event) { double('event', event: :call) }

    it 'adds the state' do
      expect {
        Rdepend::Event::Call.new(event)
      }.to change(Rdepend::State.instance, :size).by(1)
    end
  end

  describe '.name' do

    context 'an instance method' do

      let(:event) do
        double('event', defined_class: 'Bogus', method_id: 'method_name')
      end

      it 'returns the name' do
        name = 'Bogus.method_name'
        expect(Rdepend::Event::Call.new(event).name).to eq(name)
      end
    end

    context 'a class method' do

      let(:class_name) do
        '#<Class:User(id: integer, name: string)>'
      end

      let(:event) do
        double('event', defined_class: class_name, method_id: 'named')
      end

      it 'returns the name' do
        name = 'User#named'
        expect(Rdepend::Event::Call.new(event).name).to eq(name)
      end
    end

    context 'a module method' do

      let(:module_name) do
        '#<Module:UserHelper>'
      end

      let(:event) do
        double('event', defined_class: module_name, method_id: 'named')
      end

      it 'returns the name' do
        name = 'UserHelper#named'
        expect(Rdepend::Event::Call.new(event).name).to eq(name)
      end
    end
  end

  describe '.called_from' do

    let(:event) do
      double('event')
    end

    before do
      Rdepend::State.instance.push('a dummy event')
    end

    it 'returns the name' do
      expect(Rdepend::Event::Call.new(event).called_from).to eq('a dummy event')
    end
  end
end
