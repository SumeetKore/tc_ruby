require 'test/unit'
require 'watir'
include Test::Unit::Assertions


class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup

    @browser = Watir::Browser.new :chrome
    @browser.goto 'https://secure.bestprice.rankingsandreviews.com/nc/homepage'
    @browser.div(:id => 's2id_home_select_make').click
    @browser.select_list(:id => 'home_select_make').select'Chevrolet'
    @browser.div(:id => 's2id_home_select_model').click
    @browser.select_list(:id => 'home_select_model')
    @browser.li(:text => 'Camaro').click
    @browser.text_field(:id => 'home_zip').set('90210')
    @browser.span(:id =>'home_cta').click
    @browser.url == 'https://secure.bestprice.rankingsandreviews.com/nc/configurator/307715?popular_trim=true'


  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  #Test case to check if following text present on webpage
  def test_actions
    #Assert text presnt on webpage
    assert (@browser.text.include?('2017 Chevrolet Camaro')== true)

    @browser.div(:id => 's2id_select_style').click
    @browser.element(:xpath => ".//*[@id='select2-drop']/div/input").send_keys('Convertible LT 1LT',:tab)
    @browser.button(:id => 'edit_color').click
    @browser.img(:title => 'Hyper Blue Metallic').click
    @browser.span(:class => 'oo-tab link oo-tab-incs').click
    @browser.element(:xpath => "//SPAN[@id='incentive_4000215652']").set #Figuring out this

    sleep(2)

    @browser.span(:text => 'Save & Update').click

    #Assert calculated price
    assert_equal('$30,699',@browser.span(:class => 'update-price reg-action').text,'Testing Calculated Price')

    @browser.link(:text => 'Next: View Dealer Pricing').click
    @browser.text_field(:name => 'given_name').send_keys('rrrrrrrr')
    @browser.text_field(:name => 'family_name').send_keys('fffffff')
    @browser.text_field(:name => 'street_address').send_keys('abcabc')
    @browser.text_field(:name => 'phone_number').send_keys('3103101234')
    @browser.text_field(:name => 'email_address').send_keys('abc@abc.com')
    @browser.button(:class => 'button b10 reg-form-submit').click


    if @browser.checkbox(:id => 'maap-cta-checkbox').exists? #Figuring out this
       @browser.checkbox(:id => 'maap-cta-checkbox').set
    end
    #@browser.checkbox(:class => 'tc-icon').set
    @browser.button(:id => 'maap_cta_btn').click


    assert_true @browser.url.include?'/my/dashboard/'
    assert_equal('2017 Chevrolet Camaro',@browser.h2.strong(:class => 'truncate ng-binding'))
    assert_equal('Convertible LT 1LT',@browser.h2.span(:class => 'truncate ng-binding'))
  end



end