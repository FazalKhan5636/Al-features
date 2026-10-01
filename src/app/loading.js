import React from 'react'

const Loading = () => {
  return (
    <div> 
        <div className="flex h-full items-center justify-center mt-20">
            <div className="animate-spin rounded-full h-15 w-15 border-t-2 border-b-2 border-blue-500"></div>
        </div>
    </div>
  )
} 

export default Loading;
