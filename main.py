#!/usr/bin/env python3
"""
Main Python application for the IAC-BC project.
This module demonstrates various Python features and functionality.
"""

import sys
import asyncio
import json
import os
from datetime import datetime
from typing import Dict, List, Optional


class DataProcessor:
    """A class to demonstrate object-oriented programming in Python."""
    
    def __init__(self, name: str):
        self.name = name
        self.created_at = datetime.now()
        self.data: List[Dict] = []
    
    def add_data(self, item: Dict) -> None:
        """Add a data item to the processor."""
        item['timestamp'] = datetime.now().isoformat()
        self.data.append(item)
        print(f"Added item: {item}")
    
    def get_summary(self) -> Dict:
        """Get a summary of processed data."""
        return {
            'processor_name': self.name,
            'created_at': self.created_at.isoformat(),
            'total_items': len(self.data),
            'latest_item': self.data[-1] if self.data else None
        }
    
    def export_to_json(self, filename: str) -> None:
        """Export data to a JSON file."""
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.data, f, indent=2, ensure_ascii=False)
        print(f"Data exported to {filename}")


async def fetch_data_async(delay: float = 1.0) -> Dict:
    """Simulate async data fetching."""
    print("Fetching data asynchronously...")
    await asyncio.sleep(delay)
    return {
        'id': 12345,
        'message': 'Hello from async function',
        'status': 'success'
    }


def demonstrate_list_comprehension() -> None:
    """Demonstrate Python list comprehensions and functional programming."""
    numbers = list(range(1, 11))
    
    # List comprehensions
    squares = [x**2 for x in numbers]
    even_squares = [x**2 for x in numbers if x % 2 == 0]
    
    print(f"Original numbers: {numbers}")
    print(f"Squares: {squares}")
    print(f"Even squares: {even_squares}")
    
    # Dictionary comprehension
    number_info = {x: {'square': x**2, 'cube': x**3} for x in numbers[:5]}
    print(f"Number info: {json.dumps(number_info, indent=2)}")


def file_operations_demo() -> None:
    """Demonstrate file operations."""
    filename = "sample_data.txt"
    
    # Write to file
    with open(filename, 'w', encoding='utf-8') as f:
        f.write("Hello, Python!\n")
        f.write("This is a demonstration of file operations.\n")
        f.write(f"Created at: {datetime.now()}\n")
    
    # Read from file
    if os.path.exists(filename):
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()
            print(f"File content:\n{content}")
    
    # Clean up
    if os.path.exists(filename):
        os.remove(filename)
        print(f"Cleaned up: {filename}")


async def main():
    """Main application entry point."""
    print("=" * 50)
    print("Welcome to the IAC-BC Python Application!")
    print("=" * 50)
    
    # Object-oriented programming demo
    processor = DataProcessor("IAC-BC Processor")
    
    # Add some sample data
    sample_items = [
        {'type': 'user', 'name': 'Alice', 'age': 30},
        {'type': 'user', 'name': 'Bob', 'age': 25},
        {'type': 'config', 'setting': 'debug_mode', 'value': True}
    ]
    
    for item in sample_items:
        processor.add_data(item)
    
    # Display summary
    summary = processor.get_summary()
    print(f"\nProcessor Summary:")
    print(json.dumps(summary, indent=2))
    
    # Async operations
    print(f"\n{'-' * 30}")
    async_data = await fetch_data_async(0.5)
    processor.add_data(async_data)
    
    # List comprehensions demo
    print(f"\n{'-' * 30}")
    demonstrate_list_comprehension()
    
    # File operations demo
    print(f"\n{'-' * 30}")
    file_operations_demo()
    
    # Export data
    print(f"\n{'-' * 30}")
    export_filename = "exported_data.json"
    processor.export_to_json(export_filename)
    
    print(f"\n{'-' * 30}")
    print("Application completed successfully!")
    
    # Clean up exported file
    if os.path.exists(export_filename):
        os.remove(export_filename)
        print(f"Cleaned up: {export_filename}")


if __name__ == "__main__":
    # Run the async main function
    asyncio.run(main())