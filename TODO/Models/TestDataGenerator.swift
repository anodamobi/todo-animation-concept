/*
  The MIT License (MIT)
  Copyright (c) 2018 ANODA Mobile Development Agency. http://anoda.mobi <info@anoda.mobi>
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

import Foundation

class TestDataGenerator {
    
    static var todayTasks: [Task] = [Task(title: "Meet Clients"),
                                     Task(title: "Weekly Report"),
                                     Task(title: "HTML/CSS Study", endDate: Date(timeIntervalSinceNow: 48 * 3600)),
                                     Task(title: "Design Meeting"),
                                     Task(title: "Quick Prototyping", endDate: Date(timeIntervalSinceNow: 24 * 3600))]
    
    static var workTasks: [Task] = [Task(title: "Create custom transition"),
                                    Task(title: "Upload build for beta testing", endDate: Date(timeIntervalSinceNow: 18 * 3600)),
                                    Task(title: "Create merge request"),
                                    Task(title: "Integrate third party library", endDate: Date(timeIntervalSinceNow: 40 * 3600))]
    
    static var personalTasks: [Task] = [Task(title: "Buy cheese"), Task(title: "Watch TV")]
}
