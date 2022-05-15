import os
import subprocess

class InfoEntry:
    def __init__(self, name: str, apparent_size:int, compressed_size:int) -> None:
        self.name = name
        self.apparent_size = apparent_size
        self.compressed_size = compressed_size
        
        if apparent_size == 0:
            self.ratio = 1
        else:
            self.ratio = compressed_size / apparent_size

    def __str__(self) -> str:
        return '{ratio:2.2f} {apparent_size} {compressed_size} {name}'.format(
            ratio=self.ratio,
            apparent_size=str(self.apparent_size).rjust(12),
            compressed_size=str(self.compressed_size).rjust(12),
            name=str(self.name).ljust(20)
        )

if __name__ == '__main__':

    entries = []

    for name in os.scandir('.'):
        process = subprocess.run(['du', '-B', '1', '-s', '--apparent-size', name], stdout=subprocess.PIPE)
        apparent_size_str = process.stdout.decode().split('\t', 1)[0]

        process = subprocess.run(['du', '-B', '1', '-s',  name], stdout=subprocess.PIPE)
        compressed_size_str = process.stdout.decode().split('\t', 1)[0]

        entries.append(InfoEntry(name.name, int(apparent_size_str), int(compressed_size_str)))

    entries.sort(key=lambda x: x.ratio)

    print('RATI {apparent_size} {compressed_size} {name}'.format(
            apparent_size='ACTUAL_SIZE'.rjust(12),
            compressed_size='CMP_SIZE'.rjust(12),
            name='NAME'.ljust(20)
        ))

    for e in entries:
        print(e)
