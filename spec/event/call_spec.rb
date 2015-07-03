require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event::Call do
  describe '.initialize' do
    let(:event) { double('event', defined_class: 'Null', event: :call) }

    it 'adds the state' do
      expect do
        Rdepend::Event::Call.new(event)
      end.to change(Rdepend::State.instance, :size).by(1)
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
        expect(Rdepend::Event::Call.new(event).name).to eq('User#named')
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
        expect(Rdepend::Event::Call.new(event).name).to eq('UserHelper#named')
      end
    end
  end

  describe '.method_name' do
    context 'an instance method' do
      let(:event) do
        double('event', defined_class: 'User', method_id: 'function')
      end

      it 'returns the name' do
        expect(Rdepend::Event::Call.new(event).method).to eq('.function')
      end
    end

    context 'a class method' do
      let(:class_name) do
        '#<Class:User(id: integer, name: string)>'
      end

      let(:event) do
        double('event', defined_class: class_name, method_id: 'function')
      end

      it 'returns the name' do
        expect(Rdepend::Event::Call.new(event).method).to eq('#function')
      end
    end
  end

  describe '.klass_name' do
    context 'a class' do
      let(:event) do
        double('event', defined_class: '#<Class:User(id: int)>')
      end

      it 'returns the klass_name' do
        expect(Rdepend::Event::Call.new(event).klass).to eq('User')
      end
    end

    context 'a module' do
      let(:event) do
        double('event', defined_class: '#<Module:UserHelper>')
      end

      it 'returns the module name' do
        expect(Rdepend::Event::Call.new(event).klass).to eq('UserHelper')
      end
    end
  end

  describe '.called_from' do
    let(:event) do
      double('event', defined_class: 'Null')
    end

    before do
      Rdepend::State.instance.push('a dummy event')
    end

    it "returns the event it's called from" do
      expect(Rdepend::Event::Call.new(event).called_from).to eq('a dummy event')
    end
  end

  describe '.event_type' do
    let(:event) do
      double('event', defined_class: 'Null', event: :call)
    end

    it 'returns the event type' do
      expect(Rdepend::Event::Call.new(event).event_type).to eq(:call)
    end
  end
end
