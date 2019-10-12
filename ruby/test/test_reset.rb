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
      it "displays the (re)set in the proper format" do
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

    describe "number_of_elements?" do
      it "can return the number of elements" do
        assert_equal 21, @test_numbers.number_of_elements?
      end
    end

    describe "add" do
      it "adds element to the set" do 
        flux_numbers = Reset.new([1,3,9,13])
        flux_numbers.add(4)
        assert_equal [1,3,9,13,4], flux_numbers.set
      end
      
      it "does not add existing elements to the set" do
        flux_numbers = Reset.new([1,3,9,13])
        flux_numbers.add(9)
        assert_equal [1,3,9,13], flux_numbers.set
      end
    end

    describe "remove" do
      it "does not change the set if the value is not present" do
        flux_numbers = Reset.new([1,3,9,13])
        flux_numbers.remove(4)
        assert_equal [1,3,9,13], flux_numbers.set
      end
      
      it "removes element from the set" do 
        flux_numbers = Reset.new([1,3,9,13])
        flux_numbers.remove(1)
        assert_equal [3,9,13], flux_numbers.set
      end
    end

    describe "multi-set methods" do

      it "give an ArgumentError when given a non-set" do
        errors = []

        errors.push(assert_raises {@test_numbers.has_subset?([1, 2, 3])})
        errors.push(assert_raises {@test_numbers.has_subset?("{ 1, 2, 3 }")})

        errors.push(assert_raises {@test_numbers.subset_of?([1, 2, 3])})
        errors.push(assert_raises {@test_numbers.subset_of?("{ 1, 2, 3 }")})

        errors.push(assert_raises {@test_numbers.union([1, 2, 3])})
        errors.push(assert_raises {@test_numbers.union("{ 1, 2, 3 }")})

        errors.push(assert_raises {@test_numbers.intersection([1, 2, 3])})
        errors.push(assert_raises {@test_numbers.intersection("{ 1, 2, 3 }")})

        errors.push(assert_raises {@test_numbers.difference([1, 2, 3])})
        errors.push(assert_raises {@test_numbers.difference("{ 1, 2, 3 }")})
        
        errors.each do |error|
          assert_match "Must be a Reset", error.message
          assert_equal ArgumentError, error.class
        end
      end

      describe "has_subset?" do
        it "checks if a given (re)set is a subset of the (re)set" do
          assert @test_numbers.has_subset?(@evens)
        end
      end
      
      describe "subset_of?" do
        it "checks if the (re)set is a subset of a give (re)set" do
          assert @odds.subset_of?(@test_numbers)
        end
      end

      describe "union" do
        it "create a union of the two (re)sets" do
          expected = Reset.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 17, 19])
          single_digits_and_primes = @single_digits.union(@primes)
          assert_equal expected.print, single_digits_and_primes.print
        end
      end
      
      describe "intersection" do  
        it "creates an intersection of the two (re)sets" do
          expected = Reset.new([2, 3, 5, 7])
          single_digit_primes = @single_digits.intersection(@primes)
          assert_equal expected.print, single_digit_primes.print
        end
      end
      
      describe "difference" do  
        it "gives the difference of the two (re)sets" do
          expected = Reset.new([0, 1, 4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20 ])
          nonprimes = @test_numbers.difference(@primes)
          assert_equal expected.print, nonprimes.print
        end
      end
    end
  end
end
