describe('Sample Test Suite', () => {
  test('should add two numbers correctly', () => {
    const add = (a, b) => a + b;
    expect(add(2, 3)).toBe(5);
  });

  test('should filter array elements', () => {
    const numbers = [1, 2, 3, 4, 5];
    const evens = numbers.filter(n => n % 2 === 0);
    expect(evens).toEqual([2, 4]);
  });

  test('should reverse a string', () => {
    const reverse = (str) => str.split('').reverse().join('');
    expect(reverse('hello')).toBe('olleh');
  });

  test('should check if object has property', () => {
    const obj = { name: 'John', age: 30 };
    expect(obj.hasOwnProperty('name')).toBe(true);
    expect(obj.hasOwnProperty('email')).toBe(false);
  });

  test('should handle async operations', async () => {
    const fetchData = () => new Promise(resolve => 
      setTimeout(() => resolve({ id: 1, title: 'Test' }), 100)
    );
    const data = await fetchData();
    expect(data.id).toBe(1);
  });
});
