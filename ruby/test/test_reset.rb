# -*- ruby encoding: utf-8 -*-

gem 'minitest'
require "minitest/autorun"
require "reset"

class TestReset < Minitest::Test
  
  describe "Reset" do
    
    before do
      @test_numbers = Reset.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
      @single_digits = Reset.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
      @odds = Reset.new([1, 3, 5, 7, 9, 11, 13, 15, 17, 19])
      @evens = Reset.new([2, 4, 6, 8, 10, 12, 14, 16, 18, 20])
      @primes = Reset.new([2,3,5,7,11,13,17,19])
    end
    
    describe "print" do
      it 'displays the (re)set in the proper format' do
        assert_equal "{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19 }", @odds.print
      end
    end

    describe "contains?" do
      it "contains the given value" do
        assert @odds.contains?(3) && @evens.contains?(4)
      end

      it "does not contain the given value" do
        refute @evens.contains?(0) || @primes.contains?(1)
      end
    end

    describe "empty?" do
      it "is empty" do
        empty = Reset.new()
        assert empty.empty?
      end

      it "is not empty" do
        refute @odds.empty?
      end
    end

    describe "union" do
      # it "gives an ArgumentError when given a non-set" do
      #   err1 = assert_raises ArgumentError { @odds.union([1, 2, 3]) }
      #   err2 = assert_raises ArgumentError { @odds.union("{ 1, 2, 3 }") }
      #   assert_match "Must be a set", err1.message
      #   assert_match "Must be a set", err2.message
      # end

      it 'performs a union of the two (re)sets' do
        expected = Reset.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 17, 19])
        single_digits_and_primes = @single_digits.union(@primes)
        assert_equal expected.print, single_digits_and_primes.print
      end
    end

    describe "intersection" do
      # it "gives an ArgumentError when given a non-set" do
      #   err1 = assert_raises ArgumentError { @odds.intersection([1, 2, 3]) }
      #   err2 = assert_raises ArgumentError { @odds.intersection("{ 1, 2, 3 }") }
      #   assert_match "Must be a set", err1.message
      #   assert_match "Must be a set", err2.message
      # end

    end

    describe "difference" do
      # it "gives an ArgumentError when given a non-set" do
      #   err1 = assert_raises ArgumentError { @odds.difference([1, 2, 3]) }
      #   err2 = assert_raises ArgumentError { @odds.difference("{ 1, 2, 3 }") }
      #   assert_match "Must be a set", err1.message
      #   assert_match "Must be a set", err2.message
      # end

    end

    describe "has_subset?" do
      # it "gives an ArgumentError when given a non-set" do
      #   err1 = assert_raises ArgumentError { @odds.has_subset?([1, 2, 3]) }
      #   err2 = assert_raises ArgumentError { @odds.has_subset?("{ 1, 2, 3 }") }
      #   assert_match "Must be a set", err1.message
      #   assert_match "Must be a set", err2.message
      # end

    end

    describe "subset_of?" do
      # it "gives an ArgumentError when given a non-set" do
      #   err1 = assert_raises ArgumentError { @odds.subset_of?([1, 2, 3]) }
      #   err2 = assert_raises ArgumentError { @odds.subset_of?("{ 1, 2, 3 }") }
      #   assert_match "Must be a set", err1.message
      #   assert_match "Must be a set", err2.message
      # end

    end

  
  end
end
